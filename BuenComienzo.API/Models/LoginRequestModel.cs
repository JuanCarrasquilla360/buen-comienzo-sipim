using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BuenComienzo.API.Models
{
    public class LoginRequestModel
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string project { get; set; }
    }
}