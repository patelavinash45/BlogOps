Drop function verify_email
Drop function approve_reject_blog
-- for Verify Email
Create or replace Function verify_email(userId integer,token character varying)
returns Table(return_id integer) as $$
begin
	UPDATE public.users SET is_verified = true, updated_by = 1 , updated_date = CURRENT_TIMESTAMP, verification_token = null, status = 'Active'
	WHERE id = userId AND verification_token = token ;
	return QUERY SELECT id from public.users WHERE id = userId;
end;
$$ LANGUAGE plpgsql;


-- for Approve and Reject Blog with Admin Comment
create or replace Function approve_reject_blog(blogId integer,isApproved bool,adminComment varchar, userId integer)
returns Table(return_id integer) as $$
begin 
	If isApproved Then
		Update public.blogs SET status = 'Approved', updated_by = userId , updated_date = CURRENT_TIMESTAMP Where id = blogId;
	Else 
		Update public.blogs SET status = 'Rejected', "admin_comment" = adminComment, updated_by = userId , updated_date = CURRENT_TIMESTAMP 
		Where id = blogId;
	end If;
	return QUERY SELECT id from public.blogs WHERE id = blogId;
end;
$$ LANGUAGE plpgsql;


-- for Verify Email
select verify_email(27,'$2a$10$PJMuMbXSeBXdlSYkaV1YCecYHa.L8kOmMxWULVtRB1AaRnq9I5WXK');

-- for Reject Blog
Select approve_reject_blog(52,false,'Testing.....',1); 

-- for Approve Blog
Select approve_reject_blog(54,true,null,1);

