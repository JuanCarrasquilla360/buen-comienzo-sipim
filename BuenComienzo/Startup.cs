using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Microsoft.Owin.Cors;
using Owin;
using Microsoft.Owin.Host.SystemWeb;

[assembly: OwinStartup(typeof(BuenComienzo.Startup))]

namespace BuenComienzo
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            var config = new Microsoft.AspNet.SignalR.HubConfiguration();
            config.EnableJavaScriptProxies = false;
            app.MapSignalR();
            //app.Map("/signalr", map => {
            //    map.UseCors(CorsOptions.AllowAll);
            //    map.RunSignalR(config);
            //});
        }
    }
}
