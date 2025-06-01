using System.ComponentModel.DataAnnotations;
using System.Security;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using Tul.WebApplications.SemesterProject.Web.Models;

namespace Tul.WebApplications.SemesterProject.Web.Pages.User
{
    public class LoginModel : PageModel
    {
        [BindProperty]
        public string? user_email { get; set; }
        [BindProperty]
        //[Required(ErrorMessage = "Password is required.")]
        public string? user_password { get; set; }
        [BindProperty]
        public string? login_error { get; set; }    

        public void OnGet()
        {
            user_email = (TempData["email"] ?? "").ToString();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            //user_email = Request.Form["user_email"].ToString() ?? string.Empty;
            if (string.IsNullOrEmpty(user_email))
                ModelState.AddModelError("user_email", "Email is required.");

            //var _password = Request.Form["user_password"].ToString() ?? string.Empty;
            if (string.IsNullOrEmpty(user_password))
                ModelState.AddModelError("user_password", "Password is required.");

            if (!ModelState.IsValid)
                return Page();

            var tokenHash = await Models.User.Login(user_email!, user_password!);
            if (tokenHash == null)
            {
                ModelState.AddModelError("login_error", "Invalid login attempt.");
                return Page();
            }

            HttpContext.Session.SetString("token", tokenHash.ToString()!);

            //HttpContext.Session.Set();
            //HttpContext.Session.Remove();
            //HttpContext.Session.Clear();

            return RedirectToPage("/index");
        }
    }
}
