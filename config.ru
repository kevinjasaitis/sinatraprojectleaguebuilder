require './config/environment'

use Rack::MethodOverride
use UsersController
use BuildsController
run ApplicationController