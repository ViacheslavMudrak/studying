using Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class LikePostPutDto
    {
        [Column("post_id")]
        [ForeignKey(nameof(Post))]
        public int PostId { get; set; }

        [Column("user_id")]
        [ForeignKey(nameof(User))]
        public int UserId { get; set; }

        [Column("like_it", TypeName = "bit")]
        public bool LikeIt { get; set; }

    }
}
