INSERT INTO diseas_fertilizer_solution(disease, fertilizer , solution)
VALUES
('Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot' , 
'Ammonium nitrate , Ammonium sulfate' , 
'Burying the debris under the last year crop'),

('Corn_(maize)___Common_rust_' , 
'High nitrogen fertilizer' , 
'Use resistant corn hybrids'),

('Corn_(maize)___Northern_Leaf_Blight' ,
 'K60' ,
   'Rotating away from corn for one year followed by tillage'),

('Corn_(maize)___healthy' ,
 'No' ,
 'No'),

('Grape Black rot' ,
 'Mancozeb , Ziram' ,
  'Black rot spores love moisture, so you want to reduce the amount of moisture held in the canopy by providing great air circulation'),

('Grape Esca(Black_Measles)' , 
' No ' ,
    'Apply dormant sprays to reduce inoculum levels ,
    Cut it out , 
    Scout early,
    scout often'),

('Grape Leaf blight(Isariopsis Leaf Spot)' ,
 ' Fertilizers with NPK ' , 
 'Prune or stake plants to improve air circulation and reduce fungal problems ,
  Make sure to disinfect your pruning shears (one part bleach to 4 parts water) after each cut'),

('Grape healthy','No','No'),

('Pepper,_bell___Bacterial_spot' ,
 'no-phosphorous fertilizer , low-phosphorous fertilizer' ,
  'Copper sprays can be used to control bacterial leaf spot,
   but they are not as effective when used alone on a continuous basis. Thus,
    combining these sprays with a plant resistance inducer, such as Regalia or Actigard, can provide good protection from the disease'),

('Pepper,_bell___healthy' ,
 'No' ,
  'No'),

('Potato Early blight' ,
 'Nitrogen Fertilizer' , 
 ' All of the affected leaves of the plant need to be removed.
  If all leaves on the plant are affected, you will need to pull up the entire plant'),

('Potato Late blight' ,
 'Potassium silicate fertiliser' , 
 'Eliminating cull piles and volunteer potatoes,
  using proper harvesting and storage practices, and applying fungicides when necessary'),

('Potato healthy' ,
 'No' ,
  'No'),

('Tomato Bacterial spot' ,
 'FRAC Group M01' , 'Burn,
  bury or hot compost the affected plants '),

('Tomato Early blight' ,
 'Solanum lycopersicum fertilizers' ,
  'Cover the soil under the plants with mulch,
   such as fabric, straw, plastic mulch, or dried leaves.'),

('Tomato Late blight' ,
 'Potassium silicate fertilizer' ,
  'Spraying fungicides is the most effective way to prevent late blight. '),

('Tomato Leaf Mold' ,
 'Chlorothalonil, maneb, mancozeb and copper formulations' ,
  'Remove and destroy all affected plant parts.'),

('Tomato Septoria leaf spot' ,
 'BioBoost™ All-Natural Foliar Fertilizer ' ,
  'Remove diseased leaves. If caught early, the lower infected leaves can be removed and burned or destroyed.'),

('Tomato Two-spotted spider mite' ,
 'Insecticidal soap and horticultural oil' ,
  'Physically remove them. Use a high-pressure water spray to dislodge twospotted spider mites.'),

('Tomato Target Spot' ,
 '120kg Nitrogen (N), 50kg Phosphorus (P2O5), and 50kg Potash (K2O).' ,
  'Grow the plants in full sunlight. Be sure the plants aren not crowded and that each tomato has plenty of air circulation.'),

('Tomato Yellow Leaf Curl Virus' ,
 'Petroleum jelly or Biotac' ,
  'Use a neonicotinoid insecticide, such as dinotefuran '),

('Tomato mosaic virus' ,
 'Calcium nutrition nanoagent' ,
  'Remove all infected plants and destroy them. Do NOT put them in the compost pile, as the virus may persist in infected plant matter.'),

('Tomato healthy' , 'No' , 'No');

--------QUERY------------

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Corn_(maize)___Common_rust_'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Corn_(maize)___Northern_Leaf_Blight'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Corn_(maize)___healthy'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Grape Black rot'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Grape Esca(Black_Measles)'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Grape Leaf blight(Isariopsis Leaf Spot)'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Grape healthy'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Pepper,_bell___Bacterial_spot'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Pepper,_bell___healthy'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Potato Early blight'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Potato Late blight'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Potato healthy'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato Bacterial spot'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato Early blight'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato Late blight'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato Leaf Mold'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato Septoria leaf spot'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato Two-spotted spider mite'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato Target Spot'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato Yellow Leaf Curl Virus'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato mosaic virus'

SELECT fertilizer,solution
FROM diseas_fertilizer_solution
WHERE disease LIKE 'Tomato healthy'
