using System.Security;
using System.Security.Cryptography;

using MySqlConnector;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class Token
{
    public Guid Id { get; set; }
    public SecureString Hash { get; set; }
    public async static Task<Token> Generate(Guid userId)
    {
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("INSERT INTO tokens(id, hash, user_id) VALUES ('@id','@hash','@user_id')", connection);
        command.Parameters.AddWithValue("@id", Guid.NewGuid());
        command.Parameters.AddWithValue("@hash", GenerateHash(256)); // Placeholder for hash, to be replaced with actual hash generation logic
        command.Parameters.AddWithValue("@user_id", userId);
        await command.ExecuteNonQueryAsync();

        using var command2 = new MySqlCommand("SELECT * FROM tokens ORDER BY id DESC WHERE user_id = @user_id LIMIT 1", connection);
        command2.Parameters.AddWithValue("@user_id", userId);
        using var reader = await command2.ExecuteReaderAsync();
        if (await reader.ReadAsync())
        {
            var token = new Token
            {
                Id = reader.GetGuid("id"),
                Hash = new SecureString()
            };
            // Convert the hash string to SecureString
            foreach (char c in reader.GetString("hash"))
                token.Hash.AppendChar(c);
            token.Hash.MakeReadOnly(); // Make the SecureString read-only for security
            return token;
        }

        throw new Exception("Could not find generated token in database.");
    }

    /// <summary>
    /// Generates a cryptographically secure random token of specified character length.
    /// </summary>
    /// <param name="length">The desired length of the token (in characters).</param>
    /// <returns>A secure random token string.</returns>
    private static string GenerateHash(int length)
    {
        // Length in bytes depends on encoding (Base64 or Hex). Hex = 2 chars per byte, Base64 ~4 chars per 3 bytes
        int byteLength = (int)Math.Ceiling(length * 3 / 4.0); // For Base64

        byte[] randomBytes = new byte[byteLength];
        using (var rng = RandomNumberGenerator.Create())
        {
            rng.GetBytes(randomBytes);
        }

        string base64Token = Convert.ToBase64String(randomBytes);

        // Remove non-url-safe characters and trim to requested length
        string safeToken = base64Token.Replace("+", "-").Replace("/", "_").Replace("=", "");
        return safeToken.Length > length ? safeToken.Substring(0, length) : safeToken;
    }
}
