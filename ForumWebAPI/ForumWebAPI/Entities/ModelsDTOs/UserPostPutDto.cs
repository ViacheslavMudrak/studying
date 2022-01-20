using Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class UserPostPutDto
    {
        [Column("registration_date", TypeName = "date")]
        public DateTime RegistrationDate { get; set; }

        [Required]
        [StringLength(30)]
        public string Name { get; set; }

        [Column("role_id")]
        [ForeignKey(nameof(Role))]
        public int RoleId { get; set; }
    }
}
