using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.Models
{
    [Table("likes")]
    public class Like
    {
        [Column("like_it", TypeName = "bit")]
        public bool LikeIt { get; set; }

        // Nav
        [Column("post_id")]
        [ForeignKey(nameof(Models.Post))]
        public int PostId { get; set; }
        public Post Post { get; set; }

        [Column("user_id")]
        [ForeignKey(nameof(Models.User))]
        public int UserId { get; set; }
        public User User { get; set; }

    }
}
