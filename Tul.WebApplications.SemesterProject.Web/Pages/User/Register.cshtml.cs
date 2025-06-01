using Isopoh.Cryptography.Argon2;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.RazorPages;

using MySqlConnector;

using Tul.WebApplications.SemesterProject.Web.Enums;

namespace Tul.WebApplications.SemesterProject.Web.Pages.User
{
    public class RegisterModel : PageModel
    {
        [BindProperty]
        public string? user_nickname { get; set; }
        [BindProperty]
        public string? user_email { get; set; }
        [BindProperty]
        public string? user_password { get; set; }
        [BindProperty]
        public string? user_password_confirm { get; set; }
        [BindProperty]
        public bool user_admin { get; set; } // Default to false, can be set to true for admin registration

        public void OnGet()
        {
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (string.IsNullOrEmpty(user_nickname))
                ModelState.AddModelError("user_nickname", "Nickname is required.");
            
            if (string.IsNullOrEmpty(user_email))
                ModelState.AddModelError("user_email", "Email is required.");
            
            if (string.IsNullOrEmpty(user_password))
                ModelState.AddModelError("user_password", "Password is required.");

            if (string.IsNullOrEmpty(user_password_confirm) || !(user_password!.Equals(user_password_confirm)))
                ModelState.AddModelError("user_password_confirm", "Check is not correct.");

            ModelState["user_admin"]!.ValidationState = ModelValidationState.Valid;

            if (!ModelState.IsValid)
                return Page();
            try
            {
                var user = await Models.User.RegisterAsync(user_nickname!, user_email!, user_password!, (user_admin ? Role.Admin : Role.User));
                // Optionally, you can set the session or redirect to a login page
                TempData["email"] = user_email; // data pass to next page

                return RedirectToPage("/user/login");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, ex.Message);
                return Page();
            }
        }
    }
}
