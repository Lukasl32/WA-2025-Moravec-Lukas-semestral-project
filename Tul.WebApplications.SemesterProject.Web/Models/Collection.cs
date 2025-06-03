
using MySqlConnector;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class Collection
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public string? Description { get; set; }
    public DateTime Created { get; set; }

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
                Title = reader.GetString("title"),
                Description = await reader.IsDBNullAsync(reader.GetOrdinal("description")) ? null : reader.GetString("description"),
                Created = reader.GetDateTime("created")
            });
        }
        return result;
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
}
