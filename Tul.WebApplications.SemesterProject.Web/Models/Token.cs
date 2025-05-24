using System.Security;

namespace Tul.WebApplications.SemesterProject.Web.Models;

public class Token
{
    public Guid Id { get; set; }
    public SecureString Hash { get; set; }
}
