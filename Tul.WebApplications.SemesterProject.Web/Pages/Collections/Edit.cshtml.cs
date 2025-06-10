using System.ComponentModel;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using Tul.WebApplications.SemesterProject.Web.Models;

namespace Tul.WebApplications.SemesterProject.Web.Pages.Collections
{
    public class EditModel : PageModel
    {
        [BindProperty]
        public string collection_title { get; set; } = string.Empty;
        [BindProperty]
        public string collection_description { get; set; } = string.Empty;
        
        private Collection? _collection;
        public async Task<IActionResult> OnGetAsync(Guid? id)
        {
            if (id is null)
                return NotFound();

            _collection = await Collection.GetById(id.Value);
            if(_collection is null)
                return NotFound();

            collection_title = _collection.Title;
            collection_description = _collection.Description ?? string.Empty;
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(Guid? id)
        {
            if (id is null)
                return BadRequest();
            _collection = await Collection.GetById(id.Value);

            _collection!.Title = collection_title ?? string.Empty;
            _collection!.Description = collection_description;
            await Collection.Update(_collection!);
            return RedirectToPage("/collections/list");
        }
    }
}
