const { Sequelize, DataTypes } = require("sequelize");
const fs = require("fs");

// Database connection configuration
const sequelize = new Sequelize("postgres", "root", "root", {
    host: "localhost",
    dialect: "postgres",
});

// Read the CSV file and convert it to an array of objects
const csv = fs.readFileSync("data.csv", "utf-8");

const data = csv
    .trim()
    .split("\n")
    .map((row) => {
        const [
            _id,
            name,
            host_id,
            host_name,
            neighbourhood_group,
            neighbourhood,
            latitude,
            longitude,
            room_type,
            price,
            minimum_nights,
            number_of_reviews,
            last_review,
            reviews_per_month,
            calculated_host_listings_count,
            availability_365,
        ] = row.split(",");
        return {
            name: name,
            host_id: parseInt(host_id) || null,
            host_name: host_name,
            neighbourhood_group: neighbourhood_group,
            neighbourhood: neighbourhood,
            latitude: latitude,
            longitude: longitude,
            room_type: room_type,
            price: parseFloat(price) || null,
            minimum_nights: parseInt(minimum_nights) || null,
            number_of_reviews: parseInt(number_of_reviews) || null,
            last_review: last_review,
            reviews_per_month: parseFloat(reviews_per_month) || null,
            calculated_host_listings_count: parseInt(calculated_host_listings_count) || null,
            availability_365: parseFloat(availability_365) || null,
        };
    });

// Define the "airbnb" table
const Airbnb = sequelize.define("property", {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    name: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    host_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    host_name: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    neighbourhood_group: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    neighbourhood: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    latitude: {
        type: DataTypes.REAL,
        allowNull: true,
    },
    longitude: {
        type: DataTypes.REAL,
        allowNull: true,
    },
    room_type: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    price: {
        type: DataTypes.REAL,
        allowNull: true,
    },
    minimum_nights: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    number_of_reviews: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    last_review: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    reviews_per_month: {
        type: DataTypes.REAL,
        allowNull: true,
    },
    calculated_host_listings_count: {
        type: DataTypes.REAL,
        allowNull: true,
    },
    availability_365: {
        type: DataTypes.REAL,
        allowNull: true,
    },
});

// Sync the model with the database
(async () => {
    await sequelize.sync({ force: true });
    try {
        await Airbnb.bulkCreate(data.slice(1));
        console.log('Data inserted');
        sequelize.close()
    } catch (error) {
        console.error(error);
    }
})();
