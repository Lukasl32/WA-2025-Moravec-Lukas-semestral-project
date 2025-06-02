
using MySqlConnector;

using Tul.WebApplications.SemesterProject.Web.Enums;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class Picture
{
    public Guid Id { get; set; }
    public string FileName { get; set; }
    public string FilePath { get; set; }
    public DateTime Created { get; set; }

    internal static async Task<List<Picture>> GetAllByCollectionId(Guid collectionId)
    {
        var result = new List<Picture>();
        using var connection = new MySqlConnection(Program.DB);
        await connection.OpenAsync();
        using var command = new MySqlCommand("SELECT * FROM pictures WHERE collection_id = @collection_id", connection);
        command.Parameters.AddWithValue("@collection_id", collectionId);
        using var reader = await command.ExecuteReaderAsync();
        while( await reader.ReadAsync())
        {
            result.Add(new Picture
            {
                Id = reader.GetGuid("id"),
                FileName = reader.GetString("fileName"),
                FilePath = reader.GetString("path"),
                Created = reader.GetDateTime("created")
            });
        }
        return result;
    }
}
