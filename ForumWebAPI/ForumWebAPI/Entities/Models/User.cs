using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.Models
{
    [Table("users")]
    public class User
    {
        public int Id { get; set; }

        [Column("registration_date", TypeName = "date")]
        public DateTime RegistrationDate { get; set; }

        [Required]
        [StringLength(30)]
        public string Name { get; set; }

        // Nav
        [Column("role_id")]
        [ForeignKey(nameof(Models.Role))]
        public int RoleId { get; set; }
        public Role Role { get; set; }

        public Credential Credential { get; set; }

        public ICollection<Post> Posts { get; set; }
        public ICollection<Topic> Topics { get; set; }
        public ICollection<Like> Likes { get; set; }

        public User()
        {
            Posts = new List<Post>();
            Topics = new List<Topic>();
            Likes = new List<Like>();
        }

    }
}
