# fen-logrotate

TODO: Enter the cookbook description here.


In Opsworks Layer add this json

{
	"logrotate": {
		"environment": "dev"
	}
}


To test locally add the below line in attribute file

default['logrotate']['environment']='dev'
