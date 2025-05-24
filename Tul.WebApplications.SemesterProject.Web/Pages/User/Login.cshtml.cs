using System.Security;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using Tul.WebApplications.SemesterProject.Web.Models;

namespace Tul.WebApplications.SemesterProject.Web.Pages.User
{
    public class LoginModel : PageModel
    {
        public void OnGet()
        {
        }

        public async Task<IActionResult> OnPostAsync()
        {
            var _email = Request.Form["user_email"].ToString() ?? string.Empty;
            if (string.IsNullOrEmpty(_email))
            {
                ModelState.AddModelError("user_email", "Email is required.");
                return Page();
            }

            var _password = Request.Form["user_password"].ToString() ?? string.Empty;
            if (string.IsNullOrEmpty(_password))
            {
                ModelState.AddModelError("user_password", "Password is required.");
                return Page();
            }

            var user = await Models.User.Login(_email, _password, HttpContext.Session);

            return RedirectToRoute("index");
        }
    }
}
