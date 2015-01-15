# Visualisation of refugees internal displacement flows in Jordan 

## Installation
```javascript
npm install
```

You also need to install grunt.

## Getting Started
Start a server:
```javascript
npm start
```

## Development

The main files to configure are

 * index.html
 * styles.css
 
For the data, a geojson (json/migrations.json) file is generated from 2 cvs files:

  * data/show.csv indicates the records (i.e combination origin/destination that should be displayed
  * data/data1.csv is the original preformated dataset
  
Delete migration.json if you need to regnerate the file

Some processing might be need in order to include in the dataset the aggregation per region.

A script in R execute this task (data/formatdata.R). You can run it in a console with 

```
Rscript formatdata.R
```
It takes data from the original dataset (originaldata.csv) and use the region definition (region.csv) to do the aggregation.



The project can be then be compiled. Lint and compile the project with the following command:
```javascript
grunt
```

For development you can compile a small excerpt using the `--sample` switch:
```javascript
grunt --sample
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style.
Lint your code using [Grunt](http://gruntjs.com/).

## License
Copyright (c) 2013 null2 GmbH Berlin  
This work is licensed under a [Creative Commons Attribution-NonCommercial 3.0 Unported License](http://creativecommons.org/licenses/by-nc/3.0/).
