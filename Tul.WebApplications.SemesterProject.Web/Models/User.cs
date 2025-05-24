using System.Security;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class User
{
    public Guid Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public SecureString Token { get; set; } = new SecureString(); // Use SecureString for sensitive data like tokens

}
