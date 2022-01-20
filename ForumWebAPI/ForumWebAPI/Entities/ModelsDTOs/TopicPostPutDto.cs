using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class TopicPostPutDto
    {
        [Column("date_time")]
        public DateTime DateTime { get; set; }

        [Column("user_id")]
        [ForeignKey(nameof(Models.User))]
        public int UserId { get; set; }

        [Required]
        [Column("topic_name")]
        [StringLength(200)]
        public string TopicName { get; set; }

        [Column(TypeName = "ntext")]
        public string Description { get; set; }

    }
}
