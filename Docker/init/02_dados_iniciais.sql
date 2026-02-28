-- Medicamentos de exemplo
INSERT INTO medicamento (nome, principio_ativo, forma_administracao) VALUES
  ('Losartana 50mg',   'Losartana Potássica', 'Oral - Comprimido'),
  ('Metformina 850mg', 'Cloridrato de Metformina', 'Oral - Comprimido'),
  ('AAS 100mg',        'Ácido Acetilsalicílico', 'Oral - Comprimido'),
  ('Atenolol 25mg',    'Atenolol', 'Oral - Comprimido');
 
-- Procedimentos de exemplo
INSERT INTO procedimento (nome, tipo) VALUES
  ('Aferição de Pressão Arterial', 'Controle'),
  ('Glicemia Capilar',             'Controle'),
  ('Fisioterapia Motora',          'Reabilitação'),
  ('Curativo Simples',             'Enfermagem'),
  ('Eletrocardiograma',            'Exame');
