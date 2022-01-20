using Entities.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class LikeGetDto
    {
        public int PostId { get; set; }

        public bool LikeIt { get; set; }

    }
}
