using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using Tul.WebApplications.SemesterProject.Web.Enums;
using Tul.WebApplications.SemesterProject.Web.Models;

namespace Tul.WebApplications.SemesterProject.Web.Pages.User.Management
{
    public class DeleteModel : PageModel
    {
        public async Task<IActionResult> OnGetAsync(Guid? id)
        {
            var _userIdToDelete = id;
            if (_userIdToDelete is null)
                return NotFound(); // If the collection ID is not provided, return a 404 Not Found

            var _token = HttpContext.Session.GetString("token");
            if (string.IsNullOrEmpty(_token))
                return RedirectToPage("/user/login"); // If the token is not set, redirect to the login page

           var _role = await UserModel.GetRoleById((Guid)await UserModel.GetIdByTokenAsync(_token));
            if (_role is not Role.Admin)
                return RedirectToPage("/user/login");

            await UserModel.Delete((Guid)_userIdToDelete);

            return RedirectToPage("./index"); // Redirect to the list page after deletion
        }
    }
}
