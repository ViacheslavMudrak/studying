using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class RoleDto
    {
        [Column("role_name")]
        [Required]
        [StringLength(20)]
        public string RoleName { get; set; }
    }
}
