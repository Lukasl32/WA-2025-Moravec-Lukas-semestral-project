using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using Tul.WebApplications.SemesterProject.Web.Models;

namespace Tul.WebApplications.SemesterProject.Web.Pages.Collections
{
    public class DetailModel : PageModel
    {
        public List<Picture> GeneratedItems { get; set; }
        public async Task<IActionResult> OnGetAsync(Guid? id)
        {
            var _collectionId = id;
            if (_collectionId == null)
                return NotFound();

            var _token = HttpContext.Session.GetString("token");
            if (string.IsNullOrEmpty(_token))
                return RedirectToPage("/user/login"); // If the token is not set, redirect to the login page

            var _userId = await UserModel.GetIdByTokenAsync(_token);
            if (_userId is null)
                return RedirectToPage("/user/login"); // If the user ID is not found, redirect to the login page

            GeneratedItems = await Picture.GetAllByCollectionId((Guid)_collectionId);

            return Page();
        }
    }
}
