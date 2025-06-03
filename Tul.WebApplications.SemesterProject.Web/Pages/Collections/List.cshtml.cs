using System.ComponentModel;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using Tul.WebApplications.SemesterProject.Web.Models;

namespace Tul.WebApplications.SemesterProject.Web.Pages.Collections
{
    public class ListModel : PageModel
    {
        public List<Collection> GeneratedItems { get; set; }

        public async Task<IActionResult> OnGetAsync()
        {
            var _token = HttpContext.Session.GetString("token");
            if (string.IsNullOrEmpty(_token))
                return RedirectToPage("/user/login"); // If the token is not set, redirect to the login page

            var _userId = await Models.UserModel.GetIdByTokenAsync(_token);
            if (_userId is null)
                return RedirectToPage("/user/login"); // If the user ID is not found, redirect to the login page

            GeneratedItems = await Collection.GetAllByUserId((Guid)_userId);

            return Page();
        }
    }
}
