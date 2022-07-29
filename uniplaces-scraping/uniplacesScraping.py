from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import time
from datetime import datetime
import mysql.connector

class Room:
    def __init__(self, link, rentType, rentValue, neighbourhood, title, configuration, persons, bedrooms, bathrooms, cityId):
        self.link = link
        self.rentType = rentType
        self.title = title
        self.neighbourhood = neighbourhood
        self.rentValue = rentValue
        self.configuration = configuration
        self.persons = persons
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.cityId = cityId

    def __str__(self):
        return (self.link + "\n" + 
                self.rentValue + "\n" + 
                self.rentType + "\n" +
                self.cityId + "\n" +
                self.neighbourhood + "\n" + 
                self.title + "\n" + 
                self.configuration + "\n" +
                self.persons + "\n" +
                self.bedrooms + "\n" + 
                self.bathrooms + "\n")

def main():
    startTime = datetime.now()
    connection = createDatabaseConnection()
    driver = createDriver()

    cities = findAllCities(connection)
    for city in cities:
        driver.get(generateUrlForCity(city))
        performScrapingForCity(driver, connection, city)

    driver.close()

    endTime = datetime.now()
    diffTime = endTime - startTime
    print("Total time:", diffTime.total_seconds() / 60, "minutes")

def performScrapingForCity(driver, connection, city):
    startTimeForCity = datetime.now()

    lastPage = extractLastPage(driver)
    cityId = findIdByCity(connection, city)

    for actualPage in range(lastPage):
        actualPage += 1
        print("Scraping city:", city, actualPage, "/", lastPage)
        time.sleep(3)
        try:
            performScrapingForCityInActualPage(driver, connection, cityId)
        except:
            print("Error performing in actual page")
            time.sleep(3)
        if actualPage != lastPage:
            try:
                changeToNextPage(driver)
            except:
                print("Error next page, retry...")
                driver.get(driver.current_url)
                time.sleep(5)
                lastPage = extractLastPage(driver)
                changeToNextPage(driver)

    endTimeForCity = datetime.now()
    diffTimeForCity = endTimeForCity - startTimeForCity
    print('Time for' ,city, ":", diffTimeForCity.total_seconds() / 60, "minutes")

def performScrapingForCityInActualPage(driver, connection, cityId):
    rooms = driver.find_elements(By.XPATH, "/html/body/div[1]/div/main/section/div/*")
    for roomElement in rooms:
        if roomElement.tag_name == "a":
            room = extractRoomInformation(roomElement=roomElement, cityId=cityId)
            exist = checkIfRoomExist(connection=connection, link=room.link)
            if exist:
                updateRoom(connection=connection, room=room)
            else:
                saveRoom(connection=connection, room=room)

def extractRoomInformation(roomElement, cityId):
    link = extractRoomLink(roomElement.get_attribute("href"))
    soupRoom = BeautifulSoup(roomElement.get_attribute('innerHTML'), 'html.parser')
    rentValueSoup = soupRoom.find("span", {"class": "rent__value"})
    neighbourhoodSoup = soupRoom.find("span", {"class": "property__neighbourhood"})
    titleSoup = soupRoom.find("h3", {"class": "property__title"})
    configurationSoup = soupRoom.find("div", {"class": "property__configuration"})
    rentTypeSoup = soupRoom.find("span", {"class": "property__rent-by"})
    persons = "undefined"
    bedrooms = "undefined"
    bathrooms = "undefined"
    if configurationSoup != None:
        spans = configurationSoup.find_all("span")
        if len(spans) == 3:
            persons = extractValueOnSoupElementOrUndefined(spans[0])
            bedrooms = extractValueOnSoupElementOrUndefined(spans[1])
            bathrooms = extractValueOnSoupElementOrUndefined(spans[2])

    rentValue = extractValueOnSoupElementOrUndefined(rentValueSoup)
    neighbourhood = extractValueOnSoupElementOrUndefined(neighbourhoodSoup)
    title = extractValueOnSoupElementOrUndefined(titleSoup)
    configuration = extractValueOnSoupElementOrUndefined(configurationSoup)
    rentType = extractValueOnSoupElementOrUndefined(rentTypeSoup)
    room = Room(link=link, 
                rentValue=rentValue, 
                title=title, 
                neighbourhood=neighbourhood, 
                configuration=configuration, 
                rentType=rentType, 
                persons=persons,
                bedrooms=bedrooms,
                bathrooms=bathrooms,
                cityId=cityId)
    return room

def extractValueOnSoupElementOrUndefined(soupElement):
    value = "undefined"
    if soupElement is not None:
        value = soupElement.get_text()
    return value

def extractRoomLink(completeRoomHref):
    queryPosition = completeRoomHref.find("?")
    return completeRoomHref[:queryPosition]

def extractLastPage(driver):
    try:
        pages = WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.XPATH, "//*[@id='__next']/div/main/section/ul/li[3]"))).text
        separatorPosition = pages.find("/")
        return int(pages[separatorPosition + 1:])
    except:
        return 1


def changeToNextPage(driver):
    WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.XPATH, "/html/body/div[1]/div/main/section/ul/li[4]/a"))).click()

def generateUrlForCity(city):
    return "https://www.uniplaces.com/accommodation/" + city

def findIdByCity(connection, city):
    cursor = connection.cursor()
    sql = "SELECT id FROM cities where name = %s"
    cursor.execute(sql, (city,))
    result = cursor.fetchall()
    return result[0][0]

def findAllCities(connection):
    cities = []
    cursor = connection.cursor()
    sql = "SELECT name FROM cities"
    cursor.execute(sql)
    result = cursor.fetchall()
    for city in result:
        cities.append(city[0])
    return cities

def checkIfRoomExist(connection, link):
    cursor = connection.cursor()
    sql = "SELECT * FROM rooms where link = %s"
    cursor.execute(sql, (link,))
    result = cursor.fetchall()
    return bool(result)

def saveRoom(connection, room):
    cursor = connection.cursor()
    sql = """
        INSERT INTO rooms 
            (portal_id, city_id, link, rent_value, rent_type, neighbourhood, title, configuration, persons, bedrooms, bathrooms, creation_date)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    cursor.execute(sql, (0, room.cityId, room.link, room.rentValue, room.rentType, room.neighbourhood, room.title, room.configuration, room.persons, room.bedrooms, room.bathrooms, datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
    connection.commit()

def updateRoom(connection, room):
    cursor = connection.cursor()
    sql = """
        UPDATE rooms SET
            city_id = %s,
            rent_value = %s,
            rent_type = %s,
            neighbourhood = %s,
            title = %s,
            configuration = %s,
            persons = %s,
            bedrooms = %s,
            bathrooms = %s,
            modification_date = %s
        WHERE link = %s
    """
    cursor.execute(sql, (room.cityId, room.rentValue, room.rentType, room.neighbourhood, room.title, room.configuration, room.persons, room.bedrooms, room.bathrooms, datetime.now().strftime('%Y-%m-%d %H:%M:%S'), room.link))
    connection.commit()

def createDatabaseConnection():
    dbConnection = mysql.connector.connect(
    host="tronxi.ddns.net",
    user="portal",
    password="portalpass",
    database="portal"
    )
    return dbConnection

def createDriver():
    chrome_options = Options()
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--headless")
    return webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)


if __name__ == "__main__":
    main()
