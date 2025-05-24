internal class Program
{
    internal static string DB { get; private set; }
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        var configuration = builder.Configuration; // Access the configuration object to retrieve settings
        DB = configuration["Database:TestDB"] ?? throw new InvalidOperationException("Connection string not found.");

        builder.Services.AddRazorPages();

        builder.Services.AddDistributedMemoryCache(); // Add in-memory cache for session storage
        builder.Services.AddSession(options =>
        {
            options.IdleTimeout = TimeSpan.FromMinutes(30); // Set session timeout to 30 minutes
            options.Cookie.HttpOnly = true; // Make the session cookie HTTP-only
            options.Cookie.IsEssential = true; // Make the session cookie essential for the application
        });

        var app = builder.Build();

        if (!app.Environment.IsDevelopment())
        {
            app.UseExceptionHandler("/Error");
            // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
            app.UseHsts();
        }

        app.UseRouting(); // Enable routing middleware
        app.MapStaticAssets(); // Map static assets to the app
        app.MapRazorPages(); // Map Razor pages to the app

        app.UseSession(); // Enable session middleware

        app.Run();
    }
}