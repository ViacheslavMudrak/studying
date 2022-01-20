using Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class CredentialPostPutDto
    {   
        [Required]
        [StringLength(25)]
        public string Login { get; set; }

        [Required]
        [StringLength(15)]
        public string Pasword { get; set; }

    }
}
