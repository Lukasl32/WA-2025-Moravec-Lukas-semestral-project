internal class Program
{
    internal static string DB { get; private set; }
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        var configuration = builder.Configuration;
        DB = configuration.GetConnectionString("Database:TestDB") ?? throw new InvalidOperationException("Connection string not found.");

        builder.Services.AddRazorPages();

        var app = builder.Build();

        if (!app.Environment.IsDevelopment())
        {
            app.UseExceptionHandler("/Error");
            // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
            app.UseHsts();
        }

        app.UseRouting();
        app.MapStaticAssets();
        app.MapRazorPages();

        app.Run();
    }
}