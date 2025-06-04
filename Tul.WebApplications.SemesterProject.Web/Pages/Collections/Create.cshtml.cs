using System.Threading.Tasks;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using Tul.WebApplications.SemesterProject.Web.Models;

namespace Tul.WebApplications.SemesterProject.Web.Pages.Collections
{
    public class CreateModel : PageModel
    {
        public async Task<IActionResult> OnGetAsync()
        {
            var _token = HttpContext.Session.GetString("token");
            if (string.IsNullOrEmpty(_token))
                return RedirectToPage("/user/login"); // If the token is not set, redirect to the login page

            var _userId = await Models.UserModel.GetIdByTokenAsync(_token);
            if (_userId is null)
                return RedirectToPage("/user/login"); // If the user ID is not found, redirect to the login page

            return Page();
        }

        public async Task<IActionResult> OnPost(string collection_name, string collection_date, string collection_adressees, string? collection_description)
        {
            _ = collection_date; // not implemented yet, but could be used for future features

            await Collection.Create(new Collection
            {
                Title = collection_name,
                UserId = await UserModel.GetIdByTokenAsync(HttpContext.Session.GetString("token")!) ?? Guid.Empty, // Get the user ID from the token
                Description = collection_description,
            });

            return RedirectToPage("./list"); // Return the page after form submission
        }
    }
}
