using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Reportes.To
{
    public class ReporteTo
    {
        public int IdReporte { get; set; }

        public string Nombre { get; set; }

        public string Descripcion { get; set; }

        public int IdPerfil { get; set; }

        public string IdNitOperador { get; set; }

        public string IdMunicipioOperacion { get; set; }

        public List<CamposReporteTo> CamposReporte { get; set; }
    }
}
