using System.Security;

using Isopoh.Cryptography.Argon2;

using MySqlConnector;

using Tul.WebApplications.SemesterProject.Web.Enums;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class User
{
    public required Guid Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public required string Email { get; set; } = string.Empty;
    public SecureString Token { get; set; } = new SecureString(); // Use SecureString for sensitive data like tokens

    public static async Task<User> RegisterAsync(string username, string email, string password, Role role = Role.User)
    {
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("INSERT INTO users(id, userName, email, passwordHash, role) VALUES (@id,@userName,@email,@passwordHash,@role)", connection);

        var _userId = Guid.NewGuid(); // Generate a new GUID for the user ID
        command.Parameters.AddWithValue("@id", _userId);
        command.Parameters.AddWithValue("@userName", username);
        command.Parameters.AddWithValue("@email", email);
        command.Parameters.AddWithValue("@passwordHash", Argon2.Hash(password)); // Hash the password using Argon2
        command.Parameters.AddWithValue("@role", (int)role);
        var status = await command.ExecuteNonQueryAsync();

        if(status < 1)
            throw new Exception("User registration failed. Please try again.");
        return new User
        {
            Id = _userId,
            Username = username,
            Email = email
        };
    }

    public static async Task<SecureString?> Login(string email, string password)
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

            return (await Models.Token.Generate(userId)).Hash; // Initialize SecureString for token
        }
        return null; // Return null if user not found
    }

    public User GetById(Guid userId)
    {
        throw new NotImplementedException("GetUser logic is not implemented yet.");
    }
    
    public User GetByEmail(string email)
    {
        throw new NotImplementedException("GetUserByEmail logic is not implemented yet.");
    }

    public User GetByToken(SecureString token)
    {
        throw new NotImplementedException("GetUserByToken logic is not implemented yet.");
    }
}
