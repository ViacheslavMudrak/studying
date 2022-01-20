using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.Models
{
    [Table("replies")]
    public class Reply
    {
        // Nav
        [Key]
        [Column("post_id")]
        [ForeignKey(nameof(Post))]
        public int BasePostId { get; set; }
        public Post BasePost { get; set; }

        [Key]
        [Column("answ_post_id")]
        [ForeignKey(nameof(Post))]
        public int AnswPostId { get; set; }
        public Post AnswPost { get; set; }

    }
}
