

 select p.postid,p.title,p.shortdescription,p.postdescription,p.postmeta,p.posturlslug,p.ispublished,p.postedon,p.createdby,
	p.createddate,p.poststatus,p.ModifiedDate,p.CategoryId,p.UserId
	from post p inner join category c on c.categoryid=p.categoryid