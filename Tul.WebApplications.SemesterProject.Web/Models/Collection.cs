
using MySqlConnector;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class Collection
{
    public Guid Id { get; set; }
    public string Title { get; set; }
    public DateTime Created { get; set; }

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
                Created = reader.GetDateTime("created")
            });
        }
        return result;
    }
}
