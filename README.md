# Neo Workstation

A Chef cookbook of recipes that are specific to Neo and which extends [pivotal_workstation](https://github.com/pivotal/pivotal_workstation).

## How To Setup a Machine Using Neo Workstation?

1. Create `Cheffile` in home directory

        site "http://community.opscode.com/api/v1"
        cookbook "pivotal_workstation", :git => "https://github.com/pivotal/pivotal_workstation
        cookbook "neo_workstation", :git => "https://github.com/neo/neo_workstation

2. Create `soloistrc` in home directory

    We have a standard Developer's workstation build at [https://gist.github.com/3087701](https://gist.github.com/3087701)

    With [soloistrc-builder](http://soloistrc-builder.herokuapp.com), you can also pick recipes that you need from pivotal\_workstation and/or neo\_workstation

3. `sudo gem install soloist --no-ri --no-rdoc`

4. `soloist`

## License

Copyright (C) 2012 Neo. MIT License.
