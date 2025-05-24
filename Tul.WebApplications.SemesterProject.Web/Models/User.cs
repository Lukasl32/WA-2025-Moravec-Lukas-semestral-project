using System.Security;

using Isopoh.Cryptography.Argon2;

using MySqlConnector;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class User
{
    public Guid Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public SecureString Token { get; set; } = new SecureString(); // Use SecureString for sensitive data like tokens

    public static async Task<User?> Login(string email, string password, ISession? session = null)
    {
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("SELECT * FROM users WHERE email = @email", connection);
        command.Parameters.AddWithValue("@email", email);
        using var reader = await command.ExecuteReaderAsync();
        if (await reader.ReadAsync())
        {
            var userId = reader.GetGuid("id");
            var username = reader.GetString("userName");
            var passwordHash = reader.GetString("passwordHash");
            var role = reader.GetInt32("role");

            if (!Argon2.Verify(passwordHash, password))
                return null; // Return null if password does not match

            var user = new User
            {
                Id = userId,
                Username = username,
                Email = email,
                Token = (await Models.Token.Generate(userId)).Hash // Initialize SecureString for token
            };
        }
        return null; // Return null if user not found
    }
}
