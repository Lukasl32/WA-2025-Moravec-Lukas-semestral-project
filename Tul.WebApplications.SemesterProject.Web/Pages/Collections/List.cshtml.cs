using System.ComponentModel;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using Tul.WebApplications.SemesterProject.Web.Enums;
using Tul.WebApplications.SemesterProject.Web.Models;

namespace Tul.WebApplications.SemesterProject.Web.Pages.Collections
{
    public class ListModel : PageModel
    {
        public List<Collection> MyCollectionItems { get; set; }

        public List<Collection> UserCollectionItems { get; set; } = [];

        public async Task<IActionResult> OnGetAsync()
        {
            var _token = HttpContext.Session.GetString("token");
            if (string.IsNullOrEmpty(_token))
                return RedirectToPage("/user/login"); // If the token is not set, redirect to the login page

            var _userId = await Models.UserModel.GetIdByTokenAsync(_token);
            if (_userId is null)
                return RedirectToPage("/user/login"); // If the user ID is not found, redirect to the login page

            MyCollectionItems = await Collection.GetAllByUserId((Guid)_userId);

            if (await UserModel.GetRoleById((Guid)_userId) is Role.Admin)
                await LoadUserCollections();

            return Page();
        }

        internal async Task LoadUserCollections()
        {
            var _items = await Collection.GetAll();
            UserCollectionItems = [.. _items.ExceptBy(MyCollectionItems.Select(item => item.Id), item => item.Id)]; // za pomocí LINQ vyøadíme z listu který nám vrátí databáze všechny itemy které jsou vlastní uživatelovi, tedy ty které jsou v MyCollectionItems
        }
    }
}
