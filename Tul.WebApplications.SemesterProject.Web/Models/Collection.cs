
using System.Threading.Tasks;

using MySqlConnector;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class Collection
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public Guid UserId { get; set; }
    public string? Description { get; set; }
    public DateTime Created { get; set; }

    public static async Task<List<Collection>> GetAll()
    {
        var result = new List<Collection>();
        var _userIds = new List<Guid>();
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("SELECT user_id FROM collections", connection);
        using var reader = await command.ExecuteReaderAsync();
        while (await reader.ReadAsync())
            _userIds.Add(reader.GetGuid("user_id"));

        foreach (var user in _userIds)
            result = [.. result.Concat(await GetAllByUserId(user))];

        return result;
    }
    internal static async Task<List<Collection>> GetAllByUserId(Guid userId)
    {
        var result = new List<Collection>();
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("SELECT * FROM collections WHERE user_id = @userId", connection);
        command.Parameters.AddWithValue("@userId", userId.ToString());
        using var reader = await command.ExecuteReaderAsync();
        while (await reader.ReadAsync())
        {
            result.Add(new()
            {
                Id = reader.GetGuid("id"),
                UserId = userId,
                Title = reader.GetString("title"),
                Description = await reader.IsDBNullAsync(reader.GetOrdinal("description")) ? null : reader.GetString("description"),
                Created = reader.GetDateTime("created")
            });
        }
        return result;
    }
    public static async Task<Collection?> GetById(Guid collectionId)
    {
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("SELECT * FROM collections WHERE id = @collectionId", connection);
        command.Parameters.AddWithValue("@collectionId", collectionId.ToString());
        using var reader = await command.ExecuteReaderAsync();
        if (await reader.ReadAsync())
        {
            return new Collection
            {
                Id = reader.GetGuid("id"),
                Title = reader.GetString("title"),
                Description = await reader.IsDBNullAsync(reader.GetOrdinal("description")) ? null : reader.GetString("description"),
                Created = reader.GetDateTime("created")
            };
        }
        return null;
    }


    public static async Task Create(Collection collection)
    {
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("INSERT INTO collections(id, user_id, title, description) VALUES (@id,@userId,@title,@description)", connection);
        command.Parameters.AddWithValue("@id", Guid.NewGuid());
        command.Parameters.AddWithValue("@userId", collection.UserId);
        command.Parameters.AddWithValue("@title", collection.Title);
        command.Parameters.AddWithValue("@description", collection.Description ?? (object?)DBNull.Value);
        await command.ExecuteScalarAsync();
    }
    public static async Task Update(Collection collection)
    {
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("UPDATE collections SET title=@title,description=@description WHERE id = @id", connection);
        command.Parameters.AddWithValue("@id", collection.Id.ToString());
        command.Parameters.AddWithValue("@title", collection.Title);
        command.Parameters.AddWithValue("@description", collection.Description ?? (object?)DBNull.Value);
        await command.ExecuteScalarAsync();
    }

    public static async Task Delete(Guid collectionId)
    {
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("DELETE FROM collections WHERE id = @collectionId", connection);
        command.Parameters.AddWithValue("@collectionId", collectionId.ToString());
        var result = await command.ExecuteNonQueryAsync();
        if(result < 1)
            throw new InvalidOperationException("Failed to delete collection. No rows affected.");
    }
}
