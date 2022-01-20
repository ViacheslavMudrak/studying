using Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class PostPostPutDto
    {
        [Column("date_time")]
        public DateTime DateTime { get; set; }

        [Required]
        [Column("contents")]
        [StringLength(2000)]
        public string Content { get; set; }

        [Column("topic_id")]
        [ForeignKey(nameof(Topic))]
        public int TopicId { get; set; }

        [Column("user_id")]
        [ForeignKey(nameof(User))]
        public int UserId { get; set; }

    }
}
