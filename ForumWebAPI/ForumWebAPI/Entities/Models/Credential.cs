using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.Models
{
    [Table("credentials")]
    public class Credential
    {
        [Required]
        [StringLength(25)]
        public string Login { get; set; }

        [Required]
        [StringLength(15)]
        public string Pasword { get; set; }

        // Nav
        [Key]
        [Column("user_id")]
        [ForeignKey(nameof(Models.User))]
        public int UserId { get; set; }
        public User User { get; set; }

    }
}
