using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.Models
{
    [Table("topics")]
    public class Topic
    {
        public int Id { get; set; }

        [Column("date_time")]
        public DateTime DateTime { get; set; }

        [Required]
        [Column("topic_name")]
        [StringLength(200)]
        public string TopicName { get; set; }

        [Column(TypeName = "ntext")]
        public string Description { get; set; }

        // Nav
        [Column("user_id")]
        [ForeignKey(nameof(Models.User))]
        public int UserId { get; set; }
        public User User { get; set; }

        public ICollection<Post> Posts { get; set; }

        public Topic()
        {
            Posts = new List<Post>();
        }


    }
}
