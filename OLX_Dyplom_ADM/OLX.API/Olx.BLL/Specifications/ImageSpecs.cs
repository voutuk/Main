﻿using Ardalis.Specification;
using Olx.BLL.Entities;
using Olx.BLL.Entities.FilterEntities;

namespace Olx.BLL.Specifications
{
    public static class ImageSpecs 
    {
        public class GetDeleted : Specification<AdvertImage>
        {
            public GetDeleted(bool tracking = false) =>
                Query.Where(x=>x.AdvertId == null).AsTracking(tracking);
        }
    }
}
