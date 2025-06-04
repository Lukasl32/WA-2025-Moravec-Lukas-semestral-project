using System.Diagnostics.CodeAnalysis;
using System.Security;

using Isopoh.Cryptography.Argon2;

using Microsoft.AspNetCore.Mvc.Infrastructure;

using MySqlConnector;

using Tul.WebApplications.SemesterProject.Web.Enums;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class UserModel
{
    public required Guid Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public required string Email { get; set; } = string.Empty;
    public string Token { get; set; } = string.Empty; // Use string for sensitive data like tokens
    public Role Role { get; set; } = Enums.Role.Unknown;

    public static async Task<UserModel> RegisterAsync(string username, string email, string password, Role role = Enums.Role.User)
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
        return new UserModel
        {
            Id = _userId,
            Username = username,
            Email = email
        };
    }

    public static async Task<string?> Login(string email, string password)
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

            return (await Models.Token.Generate(userId)).Hash; // Initialize string for token
        }
        return null; // Return null if user not found
    }

    public static async Task<List<UserModel>> GetAll()
    {
        var result = new List<UserModel>();
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("SELECT * FROM users ORDER BY role ASC", connection);
        using var reader = await command.ExecuteReaderAsync();
        while (await reader.ReadAsync())
        {
            result.Add(new()
            {
                Id = reader.GetGuid("id"),
                Username = reader.GetString("userName"),
                Email = reader.GetString("email"),
                Role = (Role)reader.GetInt32("role")
            });
        }
        return result;
    }

    public static UserModel GetById(Guid userId)
    {
        throw new NotImplementedException("GetUser logic is not implemented yet.");
    }
    
    public static Guid GetIdByEmail(string email)
    {
        throw new NotImplementedException("GetUserByEmail logic is not implemented yet.");
    }

    public static async Task<Guid?> GetIdByTokenAsync(string hash)
    {
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("SELECT user_id FROM tokens WHERE hash = @hash", connection);
        command.Parameters.AddWithValue("@hash", hash);
        return Guid.TryParse((await command.ExecuteScalarAsync())?.ToString(), out var userId) ? userId : null; // Return userId if valid, otherwise null
    }

    public static async Task<Role?> GetRoleById(Guid userId)
    {
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("SELECT role FROM users WHERE id = @id", connection);
        command.Parameters.AddWithValue("@id", userId);
        var value = await command.ExecuteScalarAsync();
        if (value is null)
            return null;

        return (Role)Convert.ToInt32(value);
    }
}
