
-- for Verify Email
Create or replace Function verify_email(myUserId integer,token varchar, userId integer)
returns void as $$
begin
	UPDATE public.users SET is_verified = true, updated_by = userId , updated_date = CURRENT_TIMESTAMP, verification_token = null
	WHERE id = myUserId AND verification_token = token ;
end;
$$ LANGUAGE plpgsql;


-- for Approve and Reject Blog with Admin Comment
create or replace Function approve_reject_blog(blogId integer,isApproved bool,adminComment varchar, userId integer)
returns void as $$
begin 
	If isApproved Then
		Update public.blogs SET status = 'Approved', updated_by = userId , updated_date = CURRENT_TIMESTAMP Where id = blogId;
	Else 
		Update public.blogs SET status = 'Rejected', "admin_comment" = adminComment, updated_by = userId , updated_date = CURRENT_TIMESTAMP 
		Where id = blogId;
	end If;
end;
$$ LANGUAGE plpgsql;


-- for Verify Email
select verify_email(20,'$2a$10$xLIJby1jY7XwUs.6kWA0neusJOI4STUtao4mWUaziSC1kvnusoGWG',1);

-- for Reject Blog
Select approve_reject_blog(52,false,'Testing.....',1); 

-- for Approve Blog
Select approve_reject_blog(54,true,null,1);

