## Bulk Clone
Clone multiple repos at once by only providing your git target.

```bash ./git.sh username```

## Optional Params

* If target is an organization: ```-org```

* The default maximum repos to clone is 100; To change that: ```-take <count>```

* The default location to clone is current working directory; o.w: ```-dir <location>```


## Usage

```bash ./git.sh <target> [-org] [-take <count>] [-dir <location>]```