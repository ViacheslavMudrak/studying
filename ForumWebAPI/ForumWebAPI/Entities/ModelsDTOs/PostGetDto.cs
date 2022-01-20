using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace Entities.ModelsDTOs
{
    public class PostGetDto
    {
        public DateTime DateTime { get; set; }

        public string Content { get; set; }

    }
}
