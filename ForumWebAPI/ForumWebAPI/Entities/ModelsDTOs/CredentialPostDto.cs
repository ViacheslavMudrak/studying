using Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class CredentialPostDto : CredentialPostPutDto
    {
        [Key]
        [Column("user_id")]
        [ForeignKey(nameof(User))]
        public int UserId { get; set; }

    }
}
