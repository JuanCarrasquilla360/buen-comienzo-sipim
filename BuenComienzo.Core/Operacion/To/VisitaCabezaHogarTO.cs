using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Operacion.To
{
    public class VisitaCabezaHogarTO
    {
        public int IdCabezaHogar { get; set; }
        public string IdDocumento { get; set; }
        public int IdMaeTipoDocumento { get; set; }
        public string NombreCabezaHogar { get; set; }
        public string PrimerNombre { get; set; }
        public string SegundoNombre { get; set; }
        public string PrimerApellido { get; set; }
        public string SegundoApellido { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string Sexo { get; set; }
        public int IdComuna { get; set; }
        public string IdBarrio { get; set; }
        public string Direccion { get; set; }
        public string DireccionObservaciones { get; set; }        
        public string Telefono { get; set; }
        public string Celular { get; set; }
        public int IdNivelEducativo { get; set; }
        public int IdMaeTipologiaFamiliar { get; set; }
        public int IdMaeTipoSeguridadSocial { get; set; }
        public string IdMaeEAPB { get; set; }
        public string Observaciones { get; set; }
        public string IdUsuarioCreacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string IdUsuarioModificacion { get; set; }
        public DateTime FechaModificacion { get; set; }

    }
}
