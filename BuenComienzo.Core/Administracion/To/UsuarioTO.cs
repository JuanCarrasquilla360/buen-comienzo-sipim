using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Administracion.To
{
    public class UsuarioTO
    {

        public string IdDocumento { get; set; }

        public string TipoDocumento { get; set; }

        public byte? IdPerfil { get; set; }

        public string Password { get; set; }

        public bool? CambioPassword { get; set; }

        public string PrimerNombre { get; set; }

        public string SegundoNombre { get; set; }

        public string PrimerApellido { get; set; }

        public string SegundoApellido { get; set; }

        public DateTime FechaNacimiento { get; set; }

        public string Telefono { get; set; }

        public string Celular { get; set; }

        public string CorreoElectronico { get; set; }

        public string CorreoElectronicoLaboral { get; set; }

        public string IdCoordinador { get; set; }

        public string IdUsuarioCreacion { get; set; }

        public DateTime? FechaCreacion { get; set; }

        public string IdUsuarioModificacion { get; set; }

        public DateTime? FechaModificacion { get; set; }

        public string Estado { get; set; }

        public string IdOperador { get; set; }

    }
}
