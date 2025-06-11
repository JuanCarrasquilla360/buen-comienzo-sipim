using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Web.Hosting;

namespace BuenComienzo.Core
{
    public static class Logging
    {
        public static void log(string idusuario, string error)
        {
            string ruta  = HostingEnvironment.ApplicationPhysicalPath;

            if (!Directory.Exists(ruta + "Logs"))
                Directory.CreateDirectory(ruta + "Logs");
            
            FileStream fsArchivo = new FileStream(ruta + "Logs\\Log" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt", FileMode.Append, FileAccess.Write);
            StreamWriter sArchivo = new StreamWriter(fsArchivo);

            sArchivo.WriteLine(idusuario + ";" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + ";" + error);
            sArchivo.Close();
        }

    }
}
