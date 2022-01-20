using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.Models
{
    [Table("posts")]
    public class Post
    {
        public int Id { get; set; }

        [Column("date_time")]
        public DateTime DateTime { get; set; }

        [Required]
        [Column("contents")]
        [StringLength(2000)]
        public string Content { get; set; }

        // Nav
        [Column("topic_id")]
        [ForeignKey(nameof(Models.Topic))]
        public int TopicId { get; set; }
        public Topic Topic { get; set; }

        [Column("user_id")]
        [ForeignKey(nameof(Models.User))]
        public int UserId { get; set; }
        public User User { get; set; }

        public ICollection<Reply> BasePosts { get; set; }
        public ICollection<Reply> AnswPosts { get; set; }
        public ICollection<Like> Likes { get; set; }

        public Post()
        {
            BasePosts = new List<Reply>();
            AnswPosts = new List<Reply>();
            Likes = new List<Like>();
        }

    }
}
