using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.Models
{
    [Table("roles")]
    public class Role
    {
        public int Id { get; set; }

        [Column("role_name")]
        [Required(ErrorMessage = "Role Name is required")]
        [StringLength(20, ErrorMessage = "Role Name can't be longer than 20 characters")]
        public string RoleName { get; set; }

        // Nav
        public ICollection<User> Users { get; set; }

        public Role()
        {
            Users = new List<User>();
        }
    }
}
