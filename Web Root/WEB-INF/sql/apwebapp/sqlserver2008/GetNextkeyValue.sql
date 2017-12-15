CREATE PROCEDURE GetNextKeyValue
@KeyName varchar(25),
@NextKeyValue bigint = -1 out
as
	Update
		NextKeyValue
	set 
		@NextKeyValue = KeyValue = KeyValue + 1
	where
		KeyName = @KeyName

	Select @NextKeyValue;